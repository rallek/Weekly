{* Purpose of this template: Display comanagers within an external context *}
<dl>
    {foreach item='comanager' from=$items}
        <dt>{$comanager->getTitleFromDisplayPattern()}</dt>
        {if $comanager.comanagerText}
            <dd>{$comanager.comanagerText|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$comanager.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
