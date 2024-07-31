page 51289 "Applicant Job Education Card"
{
    Caption = 'Applicant Job Education Card';
    PageType = Card;
    SourceTable = "Applicant Job Education2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                }
                field("Education Type"; Rec."Education Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Name"; Rec."Qualification Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
            }
        }
    }
}
