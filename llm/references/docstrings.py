"""
This file is an example/template of how the documentation
for the function should look like.
This file is created to be used in automated systems that
uses LLM for generating content.

This file includes variables that represent docstrings that
correspond to the comment above.

This file includes functions/classes that have a documentation
to give you a better context. functions will don't include the code
for simplicity but the docstring itself represents the style and
the level of simplicity of the content you should base on.

You can see that docstrings are formed differently, depending on the
abstraction level, where they are placed.
"""

# documentation for operational (application) __init__.py module in DDD project
# that could be placed to the `operational/__init__.py` or `operational/index.ts`
OPERATINOAL_INIT_DOCSTRING = """
this is the Application (Operational) layer that could be treated
as a bridge between the Presentation layer and the rest of the application.

it basically represents all the operations in the whole application on
the top level.

each component in this layer defines specific operations that are
allowed to be performed by the user of this system in general.
"""

# the docstring that could be placed to the `domain/notifications/__init__.py`
# or `domain/notifications/index.ts`
DOMAIN_MODULE_DOCSTRING = """
REASONING
===========
generate and provide user notifications

FEATURES
===========
- define the meaning of the ``Notification``
- news, suggestions generation using LLM
"""


def update_cost(cost_id: int, **values) -> Cost:
    """update the cost with additional validations.

    PARAMS:
        - `cost_id` - candidate identifier
        - `values` - update payload

    WORKFLOW:
        - get cost instance or 404
        - if value is the same - remove it from the payload.
        - update the ``cost``
        - update ``equity``
    """

    # ...
    pass
