page 51062 "Sample Test Header"
{
    Caption = 'Sample Test Header';
    PageType = Card;
    SourceTable = "Sample Test Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Test No."; Rec."Test No.")
                {
                    ApplicationArea = All;
                }
                field("Lab section"; Rec."Lab section")
                {
                }
                field("Test to be conducted"; Rec."Test to be conducted")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        LabMgmt.SetControlAppearance(Rec);
                        CurrPage.Update();
                    end;
                }
                field(TestForm; Rec.TestForm)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        LabMgmt.SetControlAppearance(Rec);
                        CurrPage.Update();
                    end;
                }
                field("Sample Code"; Rec."Sample Code")
                {
                    ApplicationArea = All;
                }
                field("Sample Name"; Rec."Sample Name")
                {
                    ApplicationArea = All;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                }
                field("Done By No."; Rec."Done By No.")
                {
                    ApplicationArea = All;
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            part("Phosphatase Test Form"; "Phosphatase Test Form")
            {
                Caption = 'Test';
                Visible = Rec.Phosphatase;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Milk Preservation Test"; "Milk Preservation Test")
            {
                Caption = 'Test';
                Visible = Rec.MilkPreservation;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Butter Fat Test"; "Butter Fat Test")
            {
                Caption = 'Test';
                Visible = Rec.Butterfat;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Preliminary Test"; "Preliminary Test")
            {
                Caption = 'Test';
                Visible = Rec.PreliminaryTest;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Antibiotic Residues"; "Antibiotic Residues")
            {
                Caption = 'Test';
                Visible = Rec.AntibioticResidue;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Viscocity Report"; "Viscocity Report")
            {
                Caption = 'Test';
                Visible = Rec.Viscosity;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Density Report"; "Density Report")
            {
                Caption = 'Test';
                Visible = Rec.Density;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Brix Determination"; "Brix Determination")
            {
                Caption = 'Test';
                Visible = Rec.Brix;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Organoleptic Test"; "Organoleptic Test")
            {
                Caption = 'Test';
                Visible = Rec.Organoleptic;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Free fatty Acids"; "Free fatty Acids")
            {
                Caption = 'Test';
                Visible = Rec.FreeFatty;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("AcidityTestFormA"; "Acid test form A")
            {
                Caption = 'Test';
                Visible = Rec.AcidityA;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("AcidityFormA"; "Acidity Test Form B")
            {
                Caption = 'Test';
                Visible = Rec.AcidityB;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Moisture Content"; "Moisture Content")
            {
                Caption = 'Test';
                Visible = Rec.Moisture;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Coliform Counts"; "Coliform Counts")
            {
                Caption = 'Test';
                Visible = Rec.Coliform;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Staph Aureus"; "Staph Aureus")
            {
                Caption = 'Test';
                Visible = Rec.StaphAurea;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("E Coli Counts"; "E Coli Counts")
            {
                Caption = 'Test';
                Visible = Rec.Ecoli;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Salmonella Spp"; "Salmonella Spp")
            {
                Caption = 'Test';
                Visible = Rec.Salmonella;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Total Viable Counts"; "Total Viable Counts")
            {
                Caption = 'Test';
                Visible = Rec.TotalViable;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Yeast and Moulds"; "Yeast and Moulds")
            {
                Caption = 'Test';
                Visible = Rec.YeastMould;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Other Tests"; "Other Tests")
            {
                Caption = 'Test';
                Visible = Rec.Others;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Conventional Tests"; "Peroxide conventional test")
            {
                Caption = 'Test';
                Visible = Rec.Conventional;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Moulds Count"; "Moulds form")
            {
                Caption = 'Test';
                Visible = Rec.Moulds;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Aflatoxin M1"; "Aflatoxin M1")
            {
                Caption = 'Test';
                Visible = Rec.Aflatoxin;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part(Resazurin; "Preliminary Resazurin test")
            {
                Caption = 'Test';
                Visible = Rec.Resazurin;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Moisture Analyzer"; "Moisture Analyser test")
            {
                Caption = 'Test';
                Visible = Rec.MoistureAnalyzer;
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
            part("Freezing Point Form"; "Freezing Point Form")
            {
                Caption = 'Test';
                Visible = Rec."Freezing Point";
                SubPageLink = "Test No." = field("Test No."), Test = field(TestForm);
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Visible = not Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    LabMgmt.SubmitResults(Rec);
                    CurrPage.Close();
                end;
            }
            action(Reopen)
            {
                Visible = Rec.Submitted;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Submitted := false;
                    Rec.Modify();
                    exit;
                end;
            }
        }
    }
    var
        ApprovalManagement: Codeunit ApprovalMgtCuExtension;

    trigger OnAfterGetRecord()
    begin
        // LabMgmt.SetControlAppearance(Rec);
    end;

    trigger OnOpenPage()
    begin
        //LabMgmt.SetControlAppearance(Rec);
    end;

    trigger OnModifyRecord(): Boolean
    begin
    end;

    var
        LabMgmt: Codeunit "Laboratory Management";
        SampleTest: Record "Sample Test";
        SampleRecHeader: Record "Sample Test Header";
}
