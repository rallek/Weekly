'use strict';

function weeklyToday(format)
{
    var timestamp, todayDate, month, day, hours, minutes, seconds;

    timestamp = new Date();
    todayDate = '';
    if (format !== 'time') {
        month = new String((parseInt(timestamp.getMonth()) + 1));
        if (month.length === 1) {
            month = '0' + month;
        }
        day = new String(timestamp.getDate());
        if (day.length === 1) {
            day = '0' + day;
        }
        todayDate += timestamp.getFullYear() + '-' + month + '-' + day;
    }
    if (format === 'datetime') {
        todayDate += ' ';
    }
    if (format != 'date') {
        hours = new String(timestamp.getHours());
        if (hours.length === 1) {
            hours = '0' + hours;
        }
        minutes = new String(timestamp.getMinutes());
        if (minutes.length === 1) {
            minutes = '0' + minutes;
        }
        seconds = new String(timestamp.getSeconds());
        if (seconds.length === 1) {
            seconds = '0' + seconds;
        }
        todayDate += hours + ':' + minutes;// + ':' + seconds;
    }
    return todayDate;
}

// returns YYYY-MM-DD even if date is in DD.MM.YYYY
function weeklyReadDate(val, includeTime)
{
    // look if we have YYYY-MM-DD
    if (val.substr(4, 1) === '-' && val.substr(7, 1) === '-') {
        return val;
    }

    // look if we have DD.MM.YYYY
    if (val.substr(2, 1) === '.' && val.substr(4, 1) === '.') {
        var newVal = val.substr(6, 4) + '-' + val.substr(3, 2) + '-' + val.substr(0, 2);
        if (includeTime === true) {
            newVal += ' ' + val.substr(11, 5);
        }
        return newVal;
    }
}

/**
 * Performs a duplicate check for unique fields
 */
function weeklyUniqueCheck(ucOt, val, elem, ucEx)
{
    var params, request;

    $('advice-validate-unique-' + elem.id).hide();
    elem.removeClassName('validation-failed').removeClassName('validation-passed');

    // build parameters object
    params = {ot: ucOt, fn: encodeURIComponent(elem.id), v: encodeURIComponent(val), ex: ucEx};

    /** TODO fix the following call to work within validation context */
    return true;

    request = new Zikula.Ajax.Request(Zikula.Config.baseURL + 'ajax.php?module=Weekly&func=checkForDuplicate', {
        method: 'post',
        parameters: params,
        authid: 'FormAuthid',
        onComplete: function(req) {
            // check if request was successful
            if (!req.isSuccess()) {
                Zikula.showajaxerror(req.getMessage());
                return;
            }

            // get data returned by module
            var data = req.getData();
            if (data.isDuplicate !== '1') {
                $('advice-validate-unique-' + elem.id).hide();
                elem.removeClassName('validation-failed').addClassName('validation-passed');
                return true;
            } else {
                $('advice-validate-unique-' + elem.id).show();
                elem.removeClassName('validation-passed').addClassName('validation-failed');
                return false;
            }
        }
    });

    return true;
}

/**
 * Add special validation rules.
 */
function weeklyAddCommonValidationRules(objectType, id)
{
    Validation.addAllThese([
        ['validate-nospace', Zikula.__('No spaces', 'module_weekly_js'), function(val, elem) {
            var valStr;
            valStr = new String(val);
            return (valStr.indexOf(' ') === -1);
        }],
        ['validate-upload', Zikula.__('Please select a valid file extension.', 'module_weekly_js'), function(val, elem) {
            var allowedExtensions;
            if (val === '') {
                return true;
            }
            var fileExtension = '.' + val.substr(val.lastIndexOf('.') + 1);
            allowedExtensions = $(elem.id + 'FileExtensions').innerHTML;
            allowedExtensions = '(.' + allowedExtensions.replace(/, /g, '|.').replace(/,/g, '|.') + ')$';
            allowedExtensions = new RegExp(allowedExtensions, 'i');
            return allowedExtensions.test(val);
        }],
        ['validate-unique', Zikula.__('This value is already assigned, but must be unique. Please change it.', 'module_weekly_js'), function(val, elem) {
            return weeklyUniqueCheck('weekly', val, elem, id);
        }]
    ]);
}
