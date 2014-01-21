{* Purpose of this template: Display leaders within an external context *}
<dl>
    {foreach item='leader' from=$items}
        <dt>{$leader->getTitleFromDisplayPattern()}</dt>
        {if $leader.leaderDescription}
            <dd>{$leader.leaderDescription|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$leader.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
