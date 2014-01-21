{* Purpose of this template: Display search options *}
<input type="hidden" id="weeklyActive" name="active[Weekly]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="weeklyEvents" name="weeklySearchTypes[]" value="event"{if $active_event} checked="checked"{/if} />
    <label for="active_weeklyEvents">{gt text='Events' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyLeaders" name="weeklySearchTypes[]" value="leader"{if $active_leader} checked="checked"{/if} />
    <label for="active_weeklyLeaders">{gt text='Leaders' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyOrganisators" name="weeklySearchTypes[]" value="organisator"{if $active_organisator} checked="checked"{/if} />
    <label for="active_weeklyOrganisators">{gt text='Organisators' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyKind" name="weeklySearchTypes[]" value="kind"{if $active_kind} checked="checked"{/if} />
    <label for="active_weeklyKind">{gt text='Kind' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyLocations" name="weeklySearchTypes[]" value="location"{if $active_location} checked="checked"{/if} />
    <label for="active_weeklyLocations">{gt text='Locations' domain='module_weekly'}</label>
</div>
