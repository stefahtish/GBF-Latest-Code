codeunit 50100 "Custom Insert Events"
{
    trigger OnRun()
    begin
    end;
    [EventSubscriber(ObjectType::table, Database::"Supplier Category", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertSupplierCategory(var Rec: Record "Supplier Category"; RunTrigger: boolean)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
    end;
}
