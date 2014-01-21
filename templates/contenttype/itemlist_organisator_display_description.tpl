{* Purpose of this template: Display organisators within an external context *}
<dl>
    {foreach item='organisator' from=$items}
        <dt>{$organisator->getTitleFromDisplayPattern()}</dt>
        {if $organisator.organisatorText}
            <dd>{$organisator.organisatorText|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$organisator.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
