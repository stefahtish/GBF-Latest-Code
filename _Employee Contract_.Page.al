page 50517 "Employee Contract"
{
    PageType = Card;
    SourceTable = "Employee Contracts";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    trigger OnValidate()
                    begin
                        Clear(Rec.Tenure);
                        Rec."Start Date" := 0D;
                        Rec."Contract Type" := '';
                        Rec."End Date" := 0D;
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field(Tenure; Rec.Tenure)
                {
                    Caption = 'Contract Length';
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Update Contract")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Open;

                trigger OnAction()
                begin
                    if Confirm(Text002, true, Rec."Employee No", Rec."Employee Name") then begin
                        Rec.TestField("Employee No");
                        Rec.TestField("Start Date");
                        HRMgt.UpdateContract(Rec."No.", Rec."Employee No");
                        Message(Text001, Rec."Employee No", Rec."Employee Name");
                        //update leave days
                        EmployeeContracts.Reset;
                        EmployeeContracts.SetRange("Employee No", Rec."Employee No");
                        EmployeeContracts.SetRange("No.", Rec."No.");
                        if EmployeeContracts.FindFirst then HRMgt.AssignContracteeLeave(Rec."Employee No", Rec."Contract Type", Rec."End Date", EmployeeContracts);
                        Message(Text003, Rec."Employee No", Rec."Employee Name");
                        Rec.Status := Rec.Status::Released;
                    end;
                    CurrPage.Close;
                end;
            }
            action("Change request")
            {
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::Released;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    CurrPage.Close;
                end;
            }
        }
    }
    var
        HRMgt: Codeunit "HR Management";
        Text001: Label 'Employee %1 - %2 Contract details Updated Successfully.';
        Text002: Label 'Do you want to update Contract details for %1 - %2? ';
        Text003: Label 'Employee %1 - %2 Contract & Leave Updated Successfully.';
        Text004: Label 'Do you want to assign leave Days as well?';
        EmployeeContracts: Record "Employee Contracts";
}
