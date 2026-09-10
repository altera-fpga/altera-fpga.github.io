"""
MkDocs hooks for variable substitution.

This hooks file processes markdown content before MkDocs renders it,
replacing variable references like ${{env.VARIABLE}} with values from mkdocs.yml.

This file is automatically copied to repositories during the build process.
"""

import re
import yaml
import os


def load_env_variables(config):
    """Load environment variables from mkdocs.yml config.

    Returns:
        dict: Environment variables from the 'env' section
    """
    # Try to get env from config.extra
    if hasattr(config, 'extra') and isinstance(config.extra, dict):
        env_vars = config.extra.get('env', {})
        if env_vars:
            return env_vars

    # Fallback: Load directly from mkdocs.yml file
    try:
        config_file = config.config_file_path
        with open(config_file, 'r', encoding='utf-8') as f:
            yaml_content = f.read()

        # Custom YAML loader that handles Python tags without importing
        class FlexibleLoader(yaml.SafeLoader):
            pass

        def python_name_constructor(loader, suffix, node):
            # Return placeholder for Python name tags
            return f"<python:{suffix}>"

        FlexibleLoader.add_multi_constructor(
            'tag:yaml.org,2002:python/name:',
            python_name_constructor
        )

        data = yaml.load(yaml_content, Loader=FlexibleLoader)

        if not data or 'env' not in data:
            return {}

        env_vars = data['env']

        # Post-process to preserve numeric strings (e.g., "2025.10" that became 2025.1)
        for key, value in list(env_vars.items()):
            if isinstance(value, float):
                # Try to find the original value in the YAML text
                pattern = rf'^[ \t]*{re.escape(key)}:[ \t]+(\d+\.\d+)[ \t]*(?:#.*)?$'
                match = re.search(pattern, yaml_content, re.MULTILINE)
                if match:
                    original_value = match.group(1)
                    # Replace float with string if precision was lost
                    if original_value != str(value):
                        env_vars[key] = original_value

        return env_vars

    except Exception as e:
        print(f"⚠ Warning: Could not load env variables from mkdocs.yml: {e}")
        return {}


def replace_variables(markdown_text, env_vars):
    """Replace variable references in markdown text with actual values.

    Supports both ${env.VAR} and ${{env.VAR}} syntax, with optional spaces.

    Args:
        markdown_text: The markdown content to process
        env_vars: Dictionary of environment variables

    Returns:
        str: Markdown with variables replaced
    """
    if not env_vars:
        return markdown_text

    # Find all variable references: ${env.VAR} or ${{env.VAR}} or ${{ env.VAR }}
    variables = re.findall(r'\$({{? *env\.(.*?) *}}?)', markdown_text, re.IGNORECASE)

    if not variables:
        return markdown_text

    # Create uppercase mapping for case-insensitive lookup
    env_vars_upper = {k.upper(): v for k, v in env_vars.items()}

    for match in variables:
        variable = match[1]  # The variable name
        key = variable.replace(" ", "").upper()

        if key in env_vars_upper:
            value = str(env_vars_upper[key])
            # Create pattern to match this specific variable (case-insensitive)
            pattern = r"\$({{? *env\." + re.escape(variable) + r" *}}?)"
            markdown_text = re.sub(pattern, value, markdown_text, flags=re.IGNORECASE)

    return markdown_text


def on_page_markdown(markdown, page, config, files):
    """
    MkDocs hook that runs before markdown is converted to HTML.

    This is called for each page and allows us to modify the markdown content
    before it gets processed by MkDocs.

    Args:
        markdown: The markdown content of the page
        page: The Page object
        config: The global configuration object
        files: All files in the project

    Returns:
        str: Modified markdown content with variables replaced
    """
    # Load environment variables from config
    env_vars = load_env_variables(config)

    # Replace variables in the markdown
    if env_vars:
        markdown = replace_variables(markdown, env_vars)

    return markdown


def on_pre_build(config):
    """
    MkDocs hook that runs once before the build starts.

    We use this to validate that env variables are loaded correctly
    and print them for debugging.

    Args:
        config: The global configuration object
    """
    env_vars = load_env_variables(config)

    if env_vars:
        print(f"✓ Variable substitution enabled: {len(env_vars)} variables loaded")

        # Show key variables for debugging
        debug_vars = ['GSRD_TAG', 'GSRD_DATE', 'COMMON_QUARTUS_VER_S', 'GSRD_YOCTO_BRANCH']
        for key in debug_vars:
            if key in env_vars:
                print(f"  {key} = {env_vars[key]}")
    else:
        print("⚠ Warning: No environment variables found in mkdocs.yml 'env:' section")
