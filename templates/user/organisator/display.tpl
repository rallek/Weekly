{* purpose of this template: comanagers display view in user area *}
{include file='user/header.tpl'}
<div class="weekly-comanager weekly-display with-rightbox">
    {gt text='Comanager' assign='templateTitle'}
    {assign var='templateTitle' value=$comanager->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'weekly.filter_hooks.comanagers.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="weekly-rightbox">
            <h3>{gt text='Events'}</h3>
            
            {if isset($comanager.event) && $comanager.event ne null}
                {include file='user/event/include_displayItemListMany.tpl' items=$comanager.event}
            {/if}
            
            {checkpermission component='Weekly:Comanager:' instance="`$comanager.id`::" level='ACCESS_EDIT' assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($comanager.createdUserId) && $comanager.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create event' assign='createTitle'}
                <a href="{modurl modname='Weekly' type='user' func='edit' ot='event' comanager="`$comanager.id`" returnTo='userDisplayComanager'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Comanager name'}</dt>
        <dd>{$comanager.comanagerName}</dd>
        <dt>{gt text='Comanager text'}</dt>
        <dd>{$comanager.comanagerText}</dd>
        <dt>{gt text='Comanager picture'}</dt>
        <dd>{if $comanager.comanagerPicture ne ''}
          <a href="{$comanager.comanagerPictureFullPathURL}" title="{$comanager->getTitleFromDisplayPattern()|replace:"\"":""}"{if $comanager.comanagerPictureMeta.isImage} rel="imageviewer[comanager]"{/if}>
          {if $comanager.comanagerPictureMeta.isImage}
              {thumb image=$comanager.comanagerPictureFullPath objectid="comanager-`$comanager.id`" preset=$comanagerThumbPresetComanagerPicture tag=true img_alt=$comanager->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$comanager.comanagerPictureMeta.size|weeklyGetFileSize:$comanager.comanagerPictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        
    </dl>
    {include file='user/include_standardfields_display.tpl' obj=$comanager}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.comanagers.display_view' id=$comanager.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($comanager._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$comanager._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('comanager', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
