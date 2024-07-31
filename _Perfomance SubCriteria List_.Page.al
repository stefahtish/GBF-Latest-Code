page 51130 "Perfomance SubCriteria List"
{
    Caption = 'Perfomance Criteria';
    PageType = List;
    //CardPageId = "Perfomance SubCriteria";
    SourceTable = "Perfomance SubCriteria";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    caption = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    caption = 'Description';
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field(TimeFrame; Rec.TimeFrame)
                {
                    ApplicationArea = All;
                }
                field("Q1 Target"; Rec."Q1 Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Q2 Target"; Rec."Q2 Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Q3 Target"; Rec."Q3 Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Q4 Target"; Rec."Q4 Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Annual  Target"; Rec."Annual  Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of completion"; Rec."Date of completion")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Sub Indicators")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Perfomance SubIndicators";
                RunPageLink = "Indicator Code" = field(Code), "Criteria Code" = field("Criteria Code"), TimeFrame = field(TimeFrame);
            }
        }
    }
}
