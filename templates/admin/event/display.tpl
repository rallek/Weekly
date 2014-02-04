{* purpose of this template: events display view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-event weekly-display">
    {gt text='Event' assign='templateTitle'}
    {assign var='templateTitle' value=$event->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <div class="z-admin-content-pagetitle">
        {icon type='display' size='small' __alt='Details'}
        <h3>{$templateTitle|notifyfilters:'weekly.filter_hooks.events.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
    </div>

    <dl>
        <dt>{gt text='Event begin'}</dt>
        <dd>{$event.eventBegin|dateformat:'datetimebrief'}</dd>
        <dt>{gt text='Event name'}</dt>
        <dd>{$event.eventName}</dd>
        <dt>{gt text='Event day'}</dt>
        <dd>{$event.eventDay|weeklyGetListEntry:'event':'eventDay'|safetext}</dd>
        <dt>{gt text='Event begin text'}</dt>
        <dd>{$event.eventBeginText}</dd>
        <dt>{gt text='Event duration'}</dt>
        <dd>{$event.eventDuration}</dd>
        <dt>{gt text='Event message'}</dt>
        <dd>{$event.eventMessage}</dd>
        <dt>{gt text='Event text'}</dt>
        <dd>{$event.eventText}</dd>
        <dt>{gt text='Max participants'}</dt>
        <dd>{$event.maxParticipants}</dd>
        <dt>{gt text='Current participants'}</dt>
        <dd>{$event.currentParticipants}</dd>
        <dt>{gt text='Active'}</dt>
        <dd>{$event.active|yesno:true}</dd>
        <dt>{gt text='Kind'}</dt>
        <dd>
        {if isset($event.Kind) && $event.Kind ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='Weekly' type='admin' func='display' ot='kind' id=$event.Kind.id}">{strip}
            {$event.Kind->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="kindItem{$event.Kind.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='kind' id=$event.Kind.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  weeklyInitInlineWindow($('kindItem{{$event.Kind.id}}Display'), '{{$event.Kind->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$event.Kind->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        <dt>{gt text='Location'}</dt>
        <dd>
        {if isset($event.Location) && $event.Location ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='Weekly' type='admin' func='display' ot='location' id=$event.Location.id}">{strip}
            {$event.Location->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="locationItem{$event.Location.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='location' id=$event.Location.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  weeklyInitInlineWindow($('locationItem{{$event.Location.id}}Display'), '{{$event.Location->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$event.Location->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        <dt>{gt text='Manager'}</dt>
        <dd>
        {if isset($event.Manager) && $event.Manager ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='Weekly' type='admin' func='display' ot='manager' id=$event.Manager.id}">{strip}
            {$event.Manager->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="managerItem{$event.Manager.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='manager' id=$event.Manager.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  weeklyInitInlineWindow($('managerItem{{$event.Manager.id}}Display'), '{{$event.Manager->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$event.Manager->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        <dt>{gt text='Comanager'}</dt>
        <dd>
        {if isset($event.Comanager) && $event.Comanager ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='Weekly' type='admin' func='display' ot='comanager' id=$event.Comanager.id}">{strip}
            {$event.Comanager->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="comanagerItem{$event.Comanager.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='comanager' id=$event.Comanager.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  weeklyInitInlineWindow($('comanagerItem{{$event.Comanager.id}}Display'), '{{$event.Comanager->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$event.Comanager->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    {include file='admin/include_standardfields_display.tpl' obj=$event}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='weekly.ui_hooks.events.display_view' id=$event.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($event._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$event._actions}
                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    weeklyInitItemActions('event', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='admin/footer.tpl'}
