page 50178 "Procurement Documents Setup"
{
    ApplicationArea = All;
    Caption = 'Procurement Documents Setup';
    PageType = List;
    SourceTable = "Procurement Document Setup";
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
                field("Mandatory on Registration"; Rec."Mandatory on Registration")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
