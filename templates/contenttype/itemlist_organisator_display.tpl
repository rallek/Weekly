{* Purpose of this template: Display organisators within an external context *}
{foreach item='organisator' from=$items}
    <h3>{$organisator->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$organisator.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
