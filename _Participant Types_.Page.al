page 51082 "Participant Types"
{
    Caption = 'Type of Participants';
    PageType = List;
    SourceTable = "Type of Participants";
    SourceTableView = WHERE(Type = CONST(Participants));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Participants;
    end;
}
