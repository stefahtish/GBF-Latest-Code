page 51029 "Cess and Levy setup"
{
    Caption = 'Consumer safety Levy setup';
    PageType = Card;
    SourceTable = "Cess and Levy setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Levy rate"; Rec."Levy rate")
                {
                    Caption = 'Consumer safety Levy rate';
                    ApplicationArea = All;
                }
                field("Levy Penalty rate- Initial"; Rec."Levy Penalty rate- Initial")
                {
                    caption = 'Penalty rate -initial';
                    ApplicationArea = All;
                }
                field("Levy Penalty rate- subsequent"; Rec."Levy Penalty rate- subsequent")
                {
                    caption = 'Penalty rate - subsequent';
                    ApplicationArea = All;
                }
                field("Percentage of cost"; Rec."Percentage of cost")
                {
                    Caption = '% of the cost of processed milk';
                }
                Group("G/L Accounts")
                {
                    field("Levy Receivables"; Rec."Levy Receivables")
                    {
                    }
                    field("Levy Penalty Receivables"; Rec."Levy Penalty Receivables")
                    {
                    }
                }
            }
        }
    }
}
