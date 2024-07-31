page 50177 "Procurement Methods List"
{
    ApplicationArea = All;
    Caption = 'Procurement Methods';
    PageType = List;
    SourceTable = "Procurement Method";
    UsageCategory = Lists;
    CardPageId = "Procurement Methods";

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
