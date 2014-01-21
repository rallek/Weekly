{* purpose of this template: leaders display view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-leader weekly-display with-rightbox">
    {gt text='Leader' assign='templateTitle'}
    {assign var='templateTitle' value=$leader->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <div class="z-admin-content-pagetitle">
        {icon type='display' size='small' __alt='Details'}
        <h3>{$templateTitle|notifyfilters:'weekly.filter_hooks.leaders.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
    </div>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="weekly-rightbox">
            <h4>{gt text='Events'}</h4>
            
            {if isset($leader.event) && $leader.event ne null}
                {include file='admin/event/include_displayItemListMany.tpl' items=$leader.event}
            {/if}
            
            {checkpermission component='Weekly:Leader:' instance="`$leader.id`::" level='ACCESS_ADMIN' assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($leader.createdUserId) && $leader.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create event' assign='createTitle'}
                <a href="{modurl modname='Weekly' type='admin' func='edit' ot='event' leader="`$leader.id`" returnTo='adminDisplayLeader'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Leader name'}</dt>
        <dd>{$leader.leaderName}</dd>
        <dt>{gt text='Leader description'}</dt>
        <dd>{$leader.leaderDescription}</dd>
        <dt>{gt text='Leader picture'}</dt>
        <dd>{if $leader.leaderPicture ne ''}
          <a href="{$leader.leaderPictureFullPathURL}" title="{$leader->getTitleFromDisplayPattern()|replace:"\"":""}"{if $leader.leaderPictureMeta.isImage} rel="imageviewer[leader]"{/if}>
          {if $leader.leaderPictureMeta.isImage}
              {thumb image=$leader.leaderPictureFullPath objectid="leader-`$leader.id`" preset=$leaderThumbPresetLeaderPicture tag=true img_alt=$leader->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$leader.leaderPictureMeta.size|weeklyGetFileSize:$leader.leaderPictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        
    </dl>
    {include file='admin/include_standardfields_display.tpl' obj=$leader}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.leaders.display_view' id=$leader.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($leader._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$leader._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('leader', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='admin/footer.tpl'}
