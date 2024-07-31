page 51083 "Category of Activities"
{
    PageType = List;
    SourceTable = "Type of Participants";
    SourceTableView = WHERE(Type = CONST(ActivityCAtegory));
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
                field(Local; Rec.Local)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::ActivityCategory;
    end;
}
