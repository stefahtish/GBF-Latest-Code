page 51030 "Applicant penalty Logs"
{
    Caption = 'Applicant Logs';
    PageType = List;
    SourceTable = "Applicant Penalty Logs";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                }
                field(Year; Rec.Year)
                {
                }
                field("Cess Compounded"; Rec."Cess Compounded")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cess Penalty"; Rec."Cess Penalty")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Levy Compounded"; Rec."Levy Compounded")
                {
                    caption = 'Consumer safety levy compounded';
                    ApplicationArea = All;
                }
                field("Levy Penalty"; Rec."Levy Penalty")
                {
                    caption = 'Penalty';
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
