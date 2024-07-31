page 51027 "Monthly Form of Returns"
{
    Caption = 'Monthly Form of Returns';
    PageType = List;
    CardPageId = "Monthly Form of Return";
    SourceTable = "Monthly Form of Return";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                // field("License Type"; Rec."License Type")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
}
