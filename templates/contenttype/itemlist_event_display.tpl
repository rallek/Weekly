{* Purpose of this template: Display events within an external context *}
{foreach item='event' from=$items}
    <h3>{$event->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$event.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
