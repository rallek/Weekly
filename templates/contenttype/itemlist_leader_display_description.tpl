{* Purpose of this template: Display managers within an external context *}
<dl>
    {foreach item='manager' from=$items}
        <dt>{$manager->getTitleFromDisplayPattern()}</dt>
        {if $manager.managerDescription}
            <dd>{$manager.managerDescription|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$manager.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
