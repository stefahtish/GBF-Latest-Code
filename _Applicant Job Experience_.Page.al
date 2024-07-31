page 50605 "Applicant Job Experience"
{
    Caption = 'Applicant Job Experience';
    PageType = ListPart;
    SourceTable = "Applicant Job Experience2";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Current employment"; Rec."Current employment")
                {
                    ApplicationArea = All;
                }
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = All;
                }
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = All;
                }
                field("Hierarchy Level"; Rec."Hierarchy Level")
                {
                    ApplicationArea = All;
                }
                field("Functional Area"; Rec."Functional Area")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Present Employment"; Rec."Present Employment")
                {
                    ApplicationArea = All;
                }
                field("No. of Years"; Rec."No. of Years")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Experience Span"; Rec."Experience Span")
                {
                    ApplicationArea = all;
                    Caption = 'No. Of Years';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Employer Email Address"; Rec."Employer Email Address")
                {
                    ApplicationArea = All;
                }
                field("Employer Postal Address"; Rec."Employer Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
}
