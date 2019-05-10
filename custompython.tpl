
{% extends 'python.tpl'%}

## remove cells tagged with 'no_test'
{% block codecell %}
{% if 'not_in_test' in cell['metadata'].get('tags', []) %}
{% else %}
 {{ super() }}
{% endif %}
{% endblock codecell %}