{* purpose of this template: leaders view view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-leader weekly-view">
    {gt text='Leader list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Leader:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create leader' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='admin' func='edit' ot='leader'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='leader'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='leader' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/leader/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='Weekly' type='admin' func='handleSelectedEntries'}" method="post" id="leadersViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="leader" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cLeaderName" />
                    <col id="cLeaderDescription" />
                    <col id="cLeaderPicture" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleLeaders" />
                    </th>
                    <th id="hLeaderName" scope="col" class="z-left">
                        {sortlink __linktext='Leader name' currentsort=$sort modname='Weekly' type='admin' func='view' ot='leader' sort='leaderName' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hLeaderDescription" scope="col" class="z-left">
                        {sortlink __linktext='Leader description' currentsort=$sort modname='Weekly' type='admin' func='view' ot='leader' sort='leaderDescription' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hLeaderPicture" scope="col" class="z-left">
                        {sortlink __linktext='Leader picture' currentsort=$sort modname='Weekly' type='admin' func='view' ot='leader' sort='leaderPicture' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='leader' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$leader.id}" class="leaders-checkbox" />
                    </td>
                    <td headers="hLeaderName" class="z-left">
                        {$leader.leaderName}
                    </td>
                    <td headers="hLeaderDescription" class="z-left">
                        {$leader.leaderDescription}
                    </td>
                    <td headers="hLeaderPicture" class="z-left">
                        {if $leader.leaderPicture ne ''}
                          <a href="{$leader.leaderPictureFullPathURL}" title="{$leader->getTitleFromDisplayPattern()|replace:"\"":""}"{if $leader.leaderPictureMeta.isImage} rel="imageviewer[leader]"{/if}>
                          {if $leader.leaderPictureMeta.isImage}
                              {thumb image=$leader.leaderPictureFullPath objectid="leader-`$leader.id`" preset=$leaderThumbPresetLeaderPicture tag=true img_alt=$leader->getTitleFromDisplayPattern()}
                          {else}
                              {gt text='Download'} ({$leader.leaderPictureMeta.size|weeklyGetFileSize:$leader.leaderPictureFullPath:false:false})
                          {/if}
                          </a>
                        {else}&nbsp;{/if}
                    </td>
                    <td id="itemActions{$leader.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($leader._actions) gt 0}
                            {foreach item='option' from=$leader._actions}
                                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$leader.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    weeklyInitItemActions('leader', 'view', 'itemActions{{$leader.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="5">
                {gt text='No leaders found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='admin' func='view' ot='leader'}
            {/if}
            <fieldset>
                <label for="weeklyAction">{gt text='With selected leaders'}</label>
                <select id="weeklyAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleLeaders') != undefined) {
        $('toggleLeaders').observe('click', function (e) {
            Zikula.toggleInput('leadersViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
