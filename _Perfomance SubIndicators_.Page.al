page 51138 "Perfomance SubIndicators"
{
    Caption = 'Perfomance SubIndicators';
    PageType = List;
    SourceTable = "Perfomance Target SubIndicator";
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Q1 Target"; Rec."Q1 Target")
                {
                    ApplicationArea = All;
                }
                field("Q2 Target"; Rec."Q2 Target")
                {
                    ApplicationArea = All;
                }
                field("Q3 Target"; Rec."Q3 Target")
                {
                    ApplicationArea = All;
                }
                field("Q4 Target"; Rec."Q4 Target")
                {
                    ApplicationArea = All;
                }
                field("Annual  Target"; Rec."Annual  Target")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
