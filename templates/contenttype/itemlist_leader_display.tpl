{* Purpose of this template: Display leaders within an external context *}
{foreach item='leader' from=$items}
    <h3>{$leader->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$leader.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
