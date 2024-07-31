page 51449 "Post Training Evaluation List"
{
    ApplicationArea = All;
    Caption = 'Post Training Evaluation List';
    PageType = List;
    CardPageId = "Post Training Evaluation";
    SourceTable = "Post Training Evaluation";
    SourceTableView = where(Submitted=const(true), archived=const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                field("Course Attended"; Rec."Course Attended")
                {
                    ToolTip = 'Specifies the value of the Course Attended field.';
                    ApplicationArea = All;
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Cost field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
