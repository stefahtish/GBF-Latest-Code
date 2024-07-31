page 50505 "Acting Duties List"
{
    CardPageID = "Acting Position Card";
    PageType = List;
    SourceTable = "Employee Acting Position";
    SourceTableView = WHERE("Promotion Type" = CONST("Acting Position"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Reliever';
                }
                field(Name; Rec.Name)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Promotion Type"; Rec."Promotion Type")
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Promotion Type" := Rec."Promotion Type"::"Acting Position";
    end;
}
