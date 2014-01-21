{* Purpose of this template: Display kind within an external context *}
{foreach item='kind' from=$items}
    <h3>{$kind->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$kind.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
