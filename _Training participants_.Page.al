page 50616 "Training participants"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Training Participant";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Training Need"; Rec."Training Need")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
