page 51215 "Projects List"
{
    Caption = 'Contract List';
    CardPageID = "Contract Creation Card";
    Editable = false;
    PageType = List;
    SourceTable = "Project Header";
    SourceTableView = where(Stage = const(Creation), "Direct Contract" = const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Tender No"; Rec."Tender No")
                {
                    ToolTip = 'Specifies the value of the Tender No field.';
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                    ApplicationArea = All;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                    ApplicationArea = All;
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    ToolTip = 'Specifies the value of the Contract Budget field.';
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Contract Name';
                    ApplicationArea = all;
                }
                field("Project Date"; Rec."Project Date")
                {
                    Caption = 'Contract Date';
                    ApplicationArea = all;
                    visible = false;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = all;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = all;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
}
