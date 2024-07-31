codeunit 50118 "Reports Management CUExt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        // if ReportId = Report::"Purchase - Invoice" then
        //     NewReportId := Report::"Purchase - Invoice Custom";
        // if ReportId = Report::"Account Schedule" then
        //     NewReportId := Report::"Purchase - Invoice Custom";
        if ReportId = Report::"Standard Sales - Invoice" then NewReportId:=Report::"Custom Sales Invoice";
        if ReportId = Report::"Sales Document - Test" then NewReportId:=Report::"Customized Test Report";
        if ReportId = Report::"Standard Sales - Pro Forma Inv" then NewReportId:=Report::"Customized Proforma Report";
        if ReportId = Report::"Standard Sales - Draft Invoice" then NewReportId:=Report::"Customized Draft Report";
    end;
// [EventSubscriber(ObjectType::Table, Database::"Acc. Schedule Name", 'OnBeforePrint', '', false, false)]
// local procedure OnBeforeAccountScheduleNamePrint(var AccScheduleName: Record "Acc. Schedule Name"; var IsHandled: Boolean)
// var
//     AccountSchedule: Report "Purchase - Invoice Custom";
// begin
//     IsHandled := true;
//     accountSchedule.SetAccSchedName(AccScheduleName.Name);
//     accountSchedule.SetColumnLayoutName(AccScheduleName."Default Column Layout");
//     accountSchedule.Run;
// end;
}
