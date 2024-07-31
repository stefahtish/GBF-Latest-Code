page 50600 "Company Job Industries"
{
    ApplicationArea = All;
    Caption = 'Company Job Industries';
    PageType = List;
    SourceTable = "Company Job Industry";
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
