page 50601 "Fields of Study"
{
    ApplicationArea = All;
    Caption = 'Fields of Study';
    PageType = List;
    SourceTable = "Field of Study";
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
            }
        }
    }
}
