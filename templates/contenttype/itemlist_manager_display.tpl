{* Purpose of this template: Display managers within an external context *}
{foreach item='manager' from=$items}
    <h3>{$manager->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$manager.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
