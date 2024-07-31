codeunit 50128 "Procurement Tasks"
{
    var Tenders: Record "Procurement Request";
    trigger OnRun()
    begin
        //Archive tenders whose closing date has elapsed
        Tenders.Reset();
        Tenders.SetRange("Process Type", Tenders."Process Type"::Tender);
        if Tenders.Find('-')then begin
            repeat if DT2Date(Tenders.TenderClosingDate) <= Today then begin
                    Tenders.Status:=Tenders.Status::Archived;
                    Tenders.Modify();
                end;
            until tenders.Next = 0;
        end;
    end;
}
