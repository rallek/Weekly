{* Purpose of this template: Display search options *}
<input type="hidden" id="weeklyActive" name="active[Weekly]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="weeklyEvents" name="weeklySearchTypes[]" value="event"{if $active_event} checked="checked"{/if} />
    <label for="active_weeklyEvents">{gt text='Events' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyManagers" name="weeklySearchTypes[]" value="manager"{if $active_manager} checked="checked"{/if} />
    <label for="active_weeklyManagers">{gt text='Managers' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyComanagers" name="weeklySearchTypes[]" value="comanager"{if $active_comanager} checked="checked"{/if} />
    <label for="active_weeklyComanagers">{gt text='Comanagers' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyKind" name="weeklySearchTypes[]" value="kind"{if $active_kind} checked="checked"{/if} />
    <label for="active_weeklyKind">{gt text='Kind' domain='module_weekly'}</label>
</div>
<div>
    <input type="checkbox" id="weeklyLocations" name="weeklySearchTypes[]" value="location"{if $active_location} checked="checked"{/if} />
    <label for="active_weeklyLocations">{gt text='Locations' domain='module_weekly'}</label>
</div>
