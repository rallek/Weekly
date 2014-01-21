{* Purpose of this template: Display locations within an external context *}
{foreach item='location' from=$items}
    <h3>{$location->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$location.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
