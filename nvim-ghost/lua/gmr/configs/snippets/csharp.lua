local luasnip = require 'luasnip'

local snippet = luasnip.snippet
local insert_node = luasnip.insert_node

local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

local filetype = 'cs'

luasnip.add_snippets(filetype, {
    snippet(
        'if',
        fmta(
            [[
if (<condition>)
{
    <body>
}<finish>
            ]],
            {
                condition = insert_node(1),
                body = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'ifinl',
        fmta(
            [[
if (<condition>) <statement>
            ]],
            {
                condition = insert_node(1),
                statement = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'elseif',
        fmta(
            [[
else if (<condition>)
{
    <body>
}<finish>
            ]],
            {
                condition = insert_node(1),
                body = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'else',
        fmta(
            [[
else
{
    <body>
}<finish>
            ]],
            {
                body = insert_node(1),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'switch',
        fmta(
            [[
switch (<expression>)
{
    <case>
}<finish>
            ]],
            {
                expression = insert_node(1),
                case = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'switcht',
        fmta(
            [[
switch (true)
{
    <case>
}<finish>
            ]],
            {
                case = insert_node(1),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'case',
        fmta(
            [[
case <case>:
    <body_case>
    break;<finish>
            ]],
            {
                case = insert_node(1),
                body_case = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'casei',
        fmta(
            [[
case <case>: <body_case>
            ]],
            {
                case = insert_node(1),
                body_case = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'default',
        fmta(
            [[
default:
    <body_case>
            ]],
            {
                body_case = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'defaulti',
        fmta(
            [[
default: <body_case>
            ]],
            {
                body_case = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'trycatch',
        fmta(
            [[
try
{
    <try_statements>
}
catch (<type_exception> <var_exception>)
{
    Console.WriteLine($"{e.Message}");
}<finish>
            ]],
            {
                try_statements = insert_node(3),
                type_exception = insert_node(1),
                var_exception = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'catch',
        fmta(
            [[
catch (<type_exception> <var_exception>)
{
    <block>
    Console.WriteLine($"{e.Message}");
}<finish>
            ]],
            {
                type_exception = insert_node(1),
                var_exception = insert_node(2),
                block = insert_node(3),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'finally',
        fmta(
            [[
finally
{
    <block>
}<finish>
            ]],
            {
                block = insert_node(1),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'trycatchfin',
        fmta(
            [[
try
{
    <try_statements>
}
catch (<type_exception> <var_exception>)
{
    <catch_statements>
    Console.WriteLine($"{e.Message}");
}
finally 
{
    <finally_statements>
}<finish>
            ]],
            {
                type_exception = insert_node(1),
                var_exception = insert_node(2),
                try_statements = insert_node(3),
                catch_statements = insert_node(4),
                finally_statements = insert_node(5),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'function',
        fmta(
            [[
<return_type> <method_name>(<parameter_list>)
{
    <body>
}<finish>
            ]],
            {
                return_type = insert_node(1),
                method_name = insert_node(2),
                parameter_list = insert_node(3),
                body = insert_node(4),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'functiongn',
        fmt(
            [[
{return_type} {method_name}<{generic_parameter_list}>({parameter_list})
{{
    {body}
}}{finish}
            ]],
            {
                return_type = insert_node(1),
                method_name = insert_node(2),
                generic_parameter_list = insert_node(3),
                parameter_list = insert_node(4),
                body = insert_node(5),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'functiongnwh',
        fmt(
            [[
{return_type} {method_name}<{generic_parameter_list}>({parameter_list}) where {where_clause}
{{
    {body}
}}{finish}
            ]],
            {
                return_type = insert_node(1),
                method_name = insert_node(2),
                generic_parameter_list = insert_node(3),
                parameter_list = insert_node(4),
                where_clause = insert_node(5),
                body = insert_node(6),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'struct',
        fmta(
            [[
struct <identifier>
{
    <field>
}<finish>
            ]],
            {
                identifier = insert_node(1),
                field = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'class',
        fmta(
            [[
class <identifier>
{
    <field>
}<finish>
            ]],
            {
                identifier = insert_node(1),
                field = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'classgn',
        fmt(
            [[
class {identifier}<{generic_parameters}>
{{
    {field}
}}{finish}
            ]],
            {
                identifier = insert_node(1),
                generic_parameters = insert_node(2),
                field = insert_node(3),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'classei',
        fmta(
            [[
class <identifier> : <class>
{
    <field>
}<finish>
            ]],
            {
                identifier = insert_node(1),
                class = insert_node(2),
                field = insert_node(3),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'interface',
        fmta(
            [[
interface <identifier>
{
    <field>
}<finish>
            ]],
            {
                identifier = insert_node(1),
                field = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'enum',
        fmta(
            [[
enum <identifier>
{
    <field>
}<finish>
            ]],
            {
                identifier = insert_node(1),
                field = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'dowhile',
        fmta(
            [[
do
{
    <block>
}
while (<statement>);
            ]],
            {
                statement = insert_node(1),
                block = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'for',
        fmta(
            [[
for (<initialization>; <condition>; <afterthought>)
{
    <statement>
}<finish>
        ]],
            {
                initialization = insert_node(1),
                condition = insert_node(2),
                afterthought = insert_node(3),
                statement = insert_node(4),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'foreach',
        fmta(
            [[
foreach (<type> <property> in <collection>) {
    <statement>
}<finish>
        ]],
            {
                type = insert_node(1),
                property = insert_node(2),
                collection = insert_node(3),
                statement = insert_node(4),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'while',
        fmta(
            [[
while (<condition>)
{
    <statement>
}<finish>
        ]],
            {
                condition = insert_node(1),
                statement = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'namespace',
        fmta(
            [[
namespace (<identifier>)
{
    <block>
}<finish>
        ]],
            {
                identifier = insert_node(1),
                block = insert_node(2),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'checked',
        fmta(
            [[
checked
{
    <block>
}<finish>
        ]],
            {
                block = insert_node(1),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'unchecked',
        fmta(
            [[
unchecked
{
    <block>
}<finish>
        ]],
            {
                block = insert_node(1),
                finish = insert_node(0),
            }
        )
    ),
})

luasnip.add_snippets(filetype, {
    snippet(
        'unsafe',
        fmta(
            [[
unsafe
{
    <block>
}<finish>
        ]],
            {
                block = insert_node(1),
                finish = insert_node(0),
            }
        )
    ),
})
