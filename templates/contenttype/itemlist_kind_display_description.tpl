{* Purpose of this template: Display kind within an external context *}
<dl>
    {foreach item='kind' from=$items}
        <dt>{$kind->getTitleFromDisplayPattern()}</dt>
        {if $kind.kindText}
            <dd>{$kind.kindText|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$kind.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
