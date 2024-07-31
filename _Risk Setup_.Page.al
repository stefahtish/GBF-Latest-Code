page 51203 "Risk Setup"
{
    PageType = Card;
    SourceTable = "Audit Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Risk Email"; Rec."Risk Email")
                {
                }
                field("Risk Reporting Nos."; Rec."Risk Reporting Nos.")
                {
                }
                field("Risk Nos."; Rec."Risk Nos.")
                {
                }
                field("Risk Survey Nos."; Rec."Risk Survey Nos.")
                {
                }
            }
            group("Risk Officer")
            {
                Caption = 'Risk Officer';

                field("Risk Officer Job ID"; Rec."Risk Officer Job ID")
                {
                }
                field("Risk Officer Job Description"; Rec."Risk Officer Job Description")
                {
                    Editable = false;
                }
            }
            group(Control10)
            {
                ShowCaption = false;

                field("Project Nos."; Rec."Project Nos.")
                {
                }
            }
        }
    }
    actions
    {
    }
}
