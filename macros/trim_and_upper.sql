{% macro trim_and_upper(string_value) %}
  {{ return(string_value.strip().upper()) }}
{% endmacro %}
