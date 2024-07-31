page 50312 "Procurement Committees"
{
    ApplicationArea = All;
    Caption = 'Procurement Committees';
    PageType = List;
    SourceTable = "Procurement Committees";
    UsageCategory = Lists;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Members; Rec.Members)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
