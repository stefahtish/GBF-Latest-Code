codeunit 50110 "Process Bank Acc. Rec Lines2"
{
    [EventSubscriber(ObjectType::Table, Database::"Bank Acc. Reconciliation Line", 'OnBeforeInsertEvent', '', true, true)]
    local procedure UpdateStatementAmount(RunTrigger: Boolean; var Rec: Record "Bank Acc. Reconciliation Line")
    begin
        if Rec."Credit Amount" <> 0 then Rec."Statement Amount":=-Rec."Credit Amount";
        if Rec."Debit Amount" <> 0 then Rec."Statement Amount":=Rec."Debit Amount";
    end;
}
