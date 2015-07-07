function LoadReport() {
    var _option = _OptionId;
    if ($("#aspnetForm").valid()) {
        ShowProgress('Loading...');
        if (_OptionId == 9 || _OptionId == 10) {
//            Report_DayCareReport.LoadReport(
//            _option, _centreId, 
//            _centreName,
//            _programId, _programName,
//             _clientId, _clientName,
//            _clientNric, _yearFrom, _monthFrom,
//            _yearTo, _monthTo, LoadReport_Callback);

            Report_DayCareReport.LoadReport(
            '9', '16',
            'CentreName',
            '83', 'ProgramName',
            '1705', 'ClientName',
            'S2083641E', '2015', '04',
            '2015', '05', LoadReport_Callback);
        }
        else {
            _startDate = $('#txtStart').val();
            _endDate = $('#txtEnd').val();
            Report_DayCareReport.LoadReport(_option, 0, _startDate, 
            _endDate, LoadReport_Callback);
        }
    }
}