page 50402 "Job Requirements Lines"
{
    Caption = 'Job Qualifications';
    PageType = ListPart;
    SourceTable = "Job Requirements";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                }
                field(Qualification; Rec.Qualification)
                {
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                }
                field("Job Specification"; Rec."Job Specification")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
