report 50329 "Procurement Plan"
{
    Caption = 'Procurement Plan';
    DefaultLayout = RDLC;
    RDLCLayout = './ProcurementPlan.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(ProcurementPlan; "Procurement Plan")
        {
            column(COmp_Logo; COmpinfor.Picture)
            {
            }
            column(COmp_Name; COmpinfor.Name)
            {
            }
            column(ProcurementType; "Procurement Type")
            {
            }
            column(ProcurementMethod; "Procurement Method")
            {
            }
            column(ProcessType; "Process Type")
            {
            }
            column(ItemDescription; "Item Description")
            {
            }
            column(SourceofFunds; "Source of Funds")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(PWDS; PWDS)
            {
            }
            column(Citizencontractors; "Citizen contractors")
            {
            }
            column(Women; Women)
            {
            }
            column(Youth; Youth)
            {
            }
            column(EstimatedCost; "Estimated Cost")
            {
            }
            column(FundsProvider; "Funds Provider")
            {
            }
            column(AGPOGeneral_ProcurementPlan; "AGPO/General")
            {
            }
            column(Department_Code; "Department Code")
            {
            }
            column(TimingDec_1; TimingDec[1])
            {
            }
            column(TimingDec_2; TimingDec[2])
            {
            }
            column(TimingDec_3; TimingDec[3])
            {
            }
            column(TimingDec_4; TimingDec[4])
            {
            }
            column(No_; "No.")
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
            {
            }
            column(Procurement_Plan_Description; "Procurement Plan Description")
            {
            }
            column(Item_Description; "Item Description")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Plan_Item_No; "Plan Item No")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(TimingDec);
                case "Timing Of Activities" of
                    "Timing Of Activities"::"1st Quater":
                        begin
                            TimingDec[1] := "Estimated Cost";
                        end;
                    "Timing Of Activities"::"2nd Quarter":
                        begin
                            TimingDec[2] := "Estimated Cost";
                        end;
                    "Timing Of Activities"::"3rd Quater":
                        begin
                            TimingDec[3] := "Estimated Cost";
                        end;
                    "Timing Of Activities"::"4th Quater":
                        begin
                            TimingDec[4] := "Estimated Cost";
                        end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        COmpinfor.Get();
        COmpinfor.CalcFields(Picture);
    end;

    var
        COmpinfor: Record "Company Information";
        TimingDec: array[4] of Decimal;
}
