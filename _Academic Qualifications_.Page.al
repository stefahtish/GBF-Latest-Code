page 50606 "Academic Qualifications"
{
    ApplicationArea = All;
    Caption = 'Academic Qualifications';
    PageType = List;
    SourceTable = "Employee Qualifications";
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
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Qualification Type":=Rec."Qualification Type"::Academic;
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Qualification Type":=Rec."Qualification Type"::Academic;
    end;
}
