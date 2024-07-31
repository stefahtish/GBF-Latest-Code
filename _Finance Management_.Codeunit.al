codeunit 50142 "Finance Management"
{
    trigger OnRun()
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::AccSchedManagement, 'OnCalcCellValueOnBeforeExit', '', false, false)]
    local procedure UpdateBudgetEntries(var AccScheduleLine: Record "Acc. Schedule Line"; var ColumnLayout: Record "Column Layout"; CalcAddCurr: Boolean; var Result: Decimal)
    begin
        if ColumnLayout."Ledger Entry Type" = ColumnLayout."Ledger Entry Type"::"Budget Entries" then begin
            if AccScheduleLine."Show Opposite Sign" then Result:=Result;
        end;
    end;
    var myInt: Integer;
}
