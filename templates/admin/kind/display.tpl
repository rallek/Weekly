{* purpose of this template: kind display view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-kind weekly-display with-rightbox">
    {gt text='Kind' assign='templateTitle'}
    {assign var='templateTitle' value=$kind->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <div class="z-admin-content-pagetitle">
        {icon type='display' size='small' __alt='Details'}
        <h3>{$templateTitle|notifyfilters:'weekly.filter_hooks.kind.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
    </div>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="weekly-rightbox">
            <h4>{gt text='Events'}</h4>
            
            {if isset($kind.event) && $kind.event ne null}
                {include file='admin/event/include_displayItemListMany.tpl' items=$kind.event}
            {/if}
            
            {checkpermission component='Weekly:Kind:' instance="`$kind.id`::" level='ACCESS_ADMIN' assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($kind.createdUserId) && $kind.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create event' assign='createTitle'}
                <a href="{modurl modname='Weekly' type='admin' func='edit' ot='event' kind="`$kind.id`" returnTo='adminDisplayKind'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Kind name'}</dt>
        <dd>{$kind.kindName}</dd>
        <dt>{gt text='Kind text'}</dt>
        <dd>{$kind.kindText}</dd>
        <dt>{gt text='Kind picture'}</dt>
        <dd>{if $kind.kindPicture ne ''}
          <a href="{$kind.kindPictureFullPathURL}" title="{$kind->getTitleFromDisplayPattern()|replace:"\"":""}"{if $kind.kindPictureMeta.isImage} rel="imageviewer[kind]"{/if}>
          {if $kind.kindPictureMeta.isImage}
              {thumb image=$kind.kindPictureFullPath objectid="kind-`$kind.id`" preset=$kindThumbPresetKindPicture tag=true img_alt=$kind->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$kind.kindPictureMeta.size|weeklyGetFileSize:$kind.kindPictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        
    </dl>
    {include file='admin/include_standardfields_display.tpl' obj=$kind}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.kind.display_view' id=$kind.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($kind._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$kind._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('kind', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='admin/footer.tpl'}
